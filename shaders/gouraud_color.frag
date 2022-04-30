#version 300 es

precision mediump float;

in vec3 ambient;
in vec3 diffuse;
in vec3 specular;

uniform vec3 material_color;    // Ka and Kd
uniform vec3 material_specular; // Ks

out vec4 FragColor;

void main() {
    //FragColor = vec4(material_color, 1.0);
    FragColor = vec4(((ambient[0]*material_color[0])+(diffuse[0]*material_color[0])+(specular[0]*material_specular[0])),
                     ((ambient[1]*material_color[1])+(diffuse[1]*material_color[1])+(specular[1]*material_specular[1])),
                     ((ambient[2]*material_color[2])+(diffuse[2]*material_color[2])+(specular[2]*material_specular[2])),
                     1.0);
}
