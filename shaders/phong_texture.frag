#version 300 es

precision mediump float;

in vec3 frag_pos;
in vec3 frag_normal;
in vec2 frag_texcoord;

uniform vec3 light_ambient;
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

uniform vec3 camera_position;
uniform vec3 material_color;      // Ka and Kd
uniform vec3 material_specular;   // Ks
uniform float material_shininess; // n
uniform sampler2D image;          // use in conjunction with Ka and Kd

out vec4 FragColor;

void main() {

    //FragColor = vec4(material_color, 1.0) * texture(image, frag_texcoord);

    

    vec3 camera_direction = normalize(camera_position-frag_pos);

    vec3 texture = vec3(texture(image,frag_texcoord));

    vec3 ambient = light_ambient * material_color * texture;



    vec3 light_direction = normalize(light_position0-frag_pos);

    vec3 reflected_light_direction = normalize(2.0 *dot(frag_normal,light_direction)*frag_normal-light_direction);

    vec3 diffuse = light_color0 * material_color * dot(frag_normal,light_direction) * texture;

    vec3 specular = light_color0 * material_specular * pow(dot(reflected_light_direction,camera_direction),material_shininess);


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
        light_direction = normalize(light_positioni-frag_pos);
        reflected_light_direction = normalize(2.0 *dot(frag_normal,light_direction)*frag_normal-light_direction);
        diffuse += light_colori * material_color * dot(frag_normal,light_direction) * texture;
        specular += light_colori * material_specular * pow(dot(reflected_light_direction,camera_direction),material_shininess);
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

    FragColor = vec4((ambient+diffuse+specular),1.0);

}
