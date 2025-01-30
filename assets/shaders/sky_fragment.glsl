#version 330 core
out vec4 FragColor;

void main()
{
    // Cores do céu e das nuvens
    vec3 skyColor = vec3(0.8, 0.5, 0.3); // Cor para o céu ao entardecer
    vec3 cloudColor = vec3(1.0, 0.5, 0.4); // Cor rosada para as nuvens
    vec3 sunColor = vec3(1.0, 0.9, 0.6); // Cor amarelada para o sol

    // Simular a posição do sol
    float sunFactor = smoothstep(0.7, 1.0, gl_FragCoord.y / 600.0);

    // Misturar as cores do céu e do sol
    vec3 finalColor = mix(skyColor, sunColor, sunFactor);

    // Adicionar nuvens
    float cloudFactor = smoothstep(0.2, 0.7, fract(sin(dot(gl_FragCoord.xy, vec2(12.9898, 78.233))) * 43758.5453));
    finalColor = mix(finalColor, cloudColor, cloudFactor);

    FragColor = vec4(finalColor, 1.0);
}
