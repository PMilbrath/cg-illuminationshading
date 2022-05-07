#version 300 es

precision highp float;

in vec3 vertex_position;
in vec3 vertex_normal;

uniform vec3 light_ambient;
uniform vec3 camera_position; 
uniform float material_shininess; // n
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

void main() {
    gl_Position = projection_matrix * view_matrix * model_matrix * vec4(vertex_position, 1.0);

    vec3 worldSpaceVertexPos = vec3(model_matrix * vec4(vertex_position,1.0));

    mat3 normalModelMat = inverse(transpose(mat3(model_matrix)));

    vec3 worldSpaceVertexNorm = normalize(normalModelMat * vertex_normal);

    

    vec3 camera_direction = normalize(camera_position-worldSpaceVertexPos);

    ambient = light_ambient;
    //ambient = Ia



    vec3 light_direction = normalize(light_position0-worldSpaceVertexPos);

    vec3 reflected_light_direction = normalize(2.0 *dot(worldSpaceVertexNorm,light_direction)*worldSpaceVertexNorm-light_direction);

    diffuse = light_color0 * dot(worldSpaceVertexNorm,light_direction);
                 
    //difuse = Ip * (N [dot] L)
    
    specular = light_color0 * pow(dot(reflected_light_direction,camera_direction),material_shininess);

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
        light_direction = normalize(light_positioni-worldSpaceVertexPos);
        reflected_light_direction = normalize(2.0 *dot(worldSpaceVertexNorm,light_direction)*worldSpaceVertexNorm-light_direction);
        diffuse += light_colori * dot(worldSpaceVertexNorm,light_direction);
        specular += light_colori * pow(dot(reflected_light_direction,camera_direction),material_shininess);
    }
    


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
    if(specular[0] > 1.0) {
        specular[0] = 1.0;
    }
    if(specular[1] > 1.0) {
        specular[1] = 1.0;
    }
    if(specular[2] > 1.0) {
        specular[2] = 1.0;
    }
    if(ambient[0] > 1.0) {
        ambient[0] = 1.0;
    }
    if(ambient[1] > 1.0) {
        ambient[1] = 1.0;
    }
    if(ambient[2] > 1.0) {
        ambient[2] = 1.0;
    }
    if(diffuse[0] > 1.0) {
        diffuse[0] = 1.0;
    }
    if(diffuse[1] > 1.0) {
        diffuse[1] = 1.0;
    }
    if(diffuse[2] > 1.0) {
        diffuse[2] = 1.0;
    }
    

}
