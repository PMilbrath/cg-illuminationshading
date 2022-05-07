#version 300 es

precision highp float;

in vec3 vertex_position;
in vec3 vertex_normal;
in vec2 vertex_texcoord;

uniform vec3 light_ambient;
uniform vec3 camera_position;
uniform float material_shininess;
uniform vec2 texture_scale;
uniform mat4 model_matrix;
uniform mat4 view_matrix;
uniform mat4 projection_matrix;
uniform int light_count;

uniform vec3 light_position0;
uniform vec3 light_color0;
uniform vec3 light_position1;
uniform vec3 light_color1;
uniform vec3 light_position2;
uniform vec3 light_color2;
uniform vec3 light_position3;
uniform vec3 light_color3;
uniform vec3 light_position4;
uniform vec3 light_color4;
uniform vec3 light_position5;
uniform vec3 light_color5;
uniform vec3 light_position6;
uniform vec3 light_color6;
uniform vec3 light_position7;
uniform vec3 light_color7;
uniform vec3 light_position8;
uniform vec3 light_color8;
uniform vec3 light_position9;
uniform vec3 light_color9;

out vec3 ambient;
out vec3 diffuse;
out vec3 specular;
out vec2 frag_texcoord;

void main() {
    gl_Position = projection_matrix * view_matrix * model_matrix * vec4(vertex_position, 1.0);

    vec3 world_position = vec3(model_matrix *vec4(vertex_position,1.0));

    vec3 world_normal = inverse(transpose(mat3(model_matrix)))* vertex_normal;

    
    vec3 camera_direction = normalize(camera_position-world_position);

    

    ambient = light_ambient;




    vec3 light_direction = normalize(light_position0-world_position);
    vec3 reflect_direction = normalize(2.0*dot(world_normal,light_direction)*world_normal-light_direction);

    diffuse = light_color0 * dot(world_normal,light_direction);

    specular = light_color0 * pow(dot(reflect_direction,camera_direction),material_shininess);


    vec3 light_positioni;
    vec3 light_colori;

    for(int i = 1; i < light_count; i++) {
        if(i == 1) {
            light_positioni = light_position1;
            light_colori = light_color1;
        }
        if(i == 2) {
            light_positioni = light_position2;
            light_colori = light_color2;
        }
        if(i == 3) {
            light_positioni = light_position3;
            light_colori = light_color3;
        }
        if(i == 4) {
            light_positioni = light_position4;
            light_colori = light_color4;
        }
        if(i == 5) {
            light_positioni = light_position5;
            light_colori = light_color5;
        }
        if(i == 6) {
            light_positioni = light_position6;
            light_colori = light_color6;
        }
        if(i == 7) {
            light_positioni = light_position7;
            light_colori = light_color7;
        }
        if(i == 8) {
            light_positioni = light_position8;
            light_colori = light_color8;
        }
        if(i == 9) {
            light_positioni = light_position9;
            light_colori = light_color9;
        }
        light_direction = normalize(light_positioni-world_position);
        reflect_direction = normalize(2.0 *dot(world_normal,light_direction)*world_normal-light_direction);
        diffuse += light_colori * dot(world_normal,light_direction);
        specular += light_colori * pow(dot(reflect_direction,camera_direction),material_shininess);
    }

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
