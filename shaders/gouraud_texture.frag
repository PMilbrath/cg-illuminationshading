#version 300 es

precision mediump float;

in vec3 ambient;
in vec3 diffuse;
in vec3 specular;
in vec2 frag_texcoord;

uniform vec3 material_color;    // Ka and Kd
uniform vec3 material_specular; // Ks
uniform sampler2D image;        // use in conjunction with Ka and Kd

out vec4 FragColor;

void main() {
    //FragColor = texture(image, frag_texcoord);

    vec3 texture_ambient = ambient * material_color * vec3(texture(image,frag_texcoord));
    vec3 texture_diffuse = diffuse * material_color * vec3(texture(image,frag_texcoord));
    vec3 texture_specular = specular * material_specular;

    if(texture_specular[0] < 0.0) {
        texture_specular[0] = 0.0;
    }
    if(texture_specular[1] < 0.0) {
        texture_specular[1] = 0.0;
    }
    if(texture_specular[2] < 0.0) {
        texture_specular[2] = 0.0;
    }
    if(texture_ambient[0] < 0.0) {
        texture_ambient[0] = 0.0;
    }
    if(texture_ambient[1] < 0.0) {
        texture_ambient[1] = 0.0;
    }
    if(texture_ambient[2] < 0.0) {
        texture_ambient[2] = 0.0;
    }
    if(texture_diffuse[0] < 0.0) {
        texture_diffuse[0] = 0.0;
    }
    if(texture_diffuse[1] < 0.0) {
        texture_diffuse[1] = 0.0;
    }
    if(texture_diffuse[2] < 0.0) {
        texture_diffuse[2] = 0.0;
    }
    FragColor=vec4(texture_ambient+texture_diffuse+texture_specular,1.0);
}
