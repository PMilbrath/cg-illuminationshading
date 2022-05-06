#version 300 es

precision highp float;

in vec3 vertex_position;
in vec3 vertex_normal;
in vec2 vertex_texcoord;

uniform vec3 light_ambient;
uniform vec3 light_position;
uniform vec3 light_color;
uniform vec3 camera_position;
uniform float material_shininess;
uniform vec2 texture_scale;
uniform mat4 model_matrix;
uniform mat4 view_matrix;
uniform mat4 projection_matrix;

out vec3 ambient;
out vec3 diffuse;
out vec3 specular;
out vec2 frag_texcoord;

void main() {
    gl_Position = projection_matrix * view_matrix * model_matrix * vec4(vertex_position, 1.0);

    vec3 world_position = vec3(model_matrix *vec4(vertex_position,1.0));

    vec3 world_normal = inverse(transpose(mat3(model_matrix)))* vertex_normal;

    vec3 light_direction = normalize(light_position-world_position);
    vec3 camera_direction = normalize(camera_position-world_position);
    vec3 reflect_direction = normalize(2.0*dot(world_normal,light_direction)*world_normal-light_direction);

    ambient = light_ambient;

    diffuse = light_color * dot(world_normal,light_direction);

    specular = light_color * pow(dot(reflect_direction,camera_direction),material_shininess);

    if(specular[0] < 0.0) {
        specular[0] = 0.0;
    }
    if(specular[1] < 0.0) {
        specular[1] = 0.0;
    }
    if(specular[2] < 0.0) {
        specular[2] = 0.0;
    }
    if(ambient[0] < 0.0) {
        ambient[0] = 0.0;
    }
    if(ambient[1] < 0.0) {
        ambient[1] = 0.0;
    }
    if(ambient[2] < 0.0) {
        ambient[2] = 0.0;
    }
    if(diffuse[0] < 0.0) {
        diffuse[0] = 0.0;
    }
    if(diffuse[1] < 0.0) {
        diffuse[1] = 0.0;
    }
    if(diffuse[2] < 0.0) {
        diffuse[2] = 0.0;
    }

    frag_texcoord = vertex_texcoord * texture_scale;
}
