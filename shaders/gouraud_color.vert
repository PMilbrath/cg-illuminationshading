#version 300 es

precision highp float;

in vec3 vertex_position;
in vec3 vertex_normal;

uniform vec3 light_ambient;
uniform vec3 light_position;
uniform vec3 light_color;
uniform vec3 camera_position; 
uniform float material_shininess; // n
uniform mat4 model_matrix; 
uniform mat4 view_matrix; 
uniform mat4 projection_matrix;

out vec3 ambient;
out vec3 diffuse;
out vec3 specular;

void main() {
    gl_Position = projection_matrix * view_matrix * model_matrix * vec4(vertex_position, 1.0);

    vec3 worldSpaceVertexPos = vec3(model_matrix * vec4(vertex_position,1.0));

    mat3 normalModelMat = inverse(transpose(mat3(model_matrix)));

    vec3 worldSpaceVertexNorm = normalize(normalModelMat * vertex_normal);

    vec3 light_direction = normalize(light_position-worldSpaceVertexPos);

    vec3 camera_direction = normalize(camera_position-worldSpaceVertexPos);

    vec3 reflected_light_direction = normalize(2.0 *dot(worldSpaceVertexNorm,light_direction)*worldSpaceVertexNorm-light_direction);

    ambient = light_ambient;

    //ambient = Ia

    diffuse = light_color * dot(worldSpaceVertexNorm,light_direction);
                 
    //difuse = Ip * (N [dot] L)
    
    specular = light_color * pow(dot(reflected_light_direction,camera_direction),material_shininess);


    //specular = light_color * pow(dot(normalize(2.0*dot(normalize(vertex_normal),
    //    normalize(light_position-vertex_position))*normalize(vertex_normal)-normalize(light_position-vertex_position)),
    //    normalize(camera_position-vertex_position)),material_shininess);

    //specular = Ip * (R [dot] V)^n

    //specular = Ip * normalize(2.0 * (N [dot] L) * N - L) [dot] V) ^ n

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

}
