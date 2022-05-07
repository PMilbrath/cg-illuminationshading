#version 300 es

precision mediump float;

in vec3 frag_pos;
in vec3 frag_normal;
in vec2 frag_texcoord;

uniform vec3 light_ambient;
uniform vec3 light_position;
uniform vec3 light_color;
uniform vec3 camera_position;
uniform vec3 material_color;      // Ka and Kd
uniform vec3 material_specular;   // Ks
uniform float material_shininess; // n
uniform sampler2D image;          // use in conjunction with Ka and Kd

out vec4 FragColor;

void main() {

    //FragColor = vec4(material_color, 1.0) * texture(image, frag_texcoord);

    vec3 light_direction = normalize(light_position-frag_pos);

    vec3 camera_direction = normalize(camera_position-frag_pos);

    vec3 reflected_light_direction = normalize(2.0 *dot(frag_normal,light_direction)*frag_normal-light_direction);
    
    vec3 texture = vec3(texture(image,frag_texcoord));

    vec3 ambient = light_ambient * material_color * texture;

    vec3 diffuse = light_color * material_color * dot(frag_normal,light_direction) * texture;

    vec3 specular = light_color * material_specular * pow(dot(reflected_light_direction,camera_direction),material_shininess);

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

    FragColor = vec4((ambient+diffuse+specular),1.0);

}
