#version 300 es

precision highp float;

in vec3 vertex_position;
in vec3 vertex_normal;
in vec2 vertex_texcoord;

uniform vec2 texture_scale;
uniform mat4 model_matrix;
uniform mat4 view_matrix;
uniform mat4 projection_matrix;

out vec3 frag_pos;
out vec3 frag_normal;
out vec2 frag_texcoord;

void main() {
    gl_Position = projection_matrix * view_matrix * model_matrix * vec4(vertex_position, 1.0);

    vec3 worldPos = vec3(model_matrix * vec4(vertex_position,1.0));

    mat3 worldModelMat = mat3(model_matrix);

    vec3 worldNorm = vec3(worldModelMat * vertex_normal);

    frag_pos = worldPos;

    frag_normal = worldNorm;

    frag_texcoord = vertex_texcoord * texture_scale;
}
