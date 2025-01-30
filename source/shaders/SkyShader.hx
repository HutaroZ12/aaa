package shaders;

class SkyShader {
    public static function loadShaders():ShaderProgram {
        var vertexShader = Assets.loadText("assets/shaders/sky_vertex.glsl");
        var fragmentShader = Assets.loadText("assets/shaders/sky_fragment.glsl");

        var program = new ShaderProgram();
        program.attach(vertexShader, GL.VERTEX_SHADER);
        program.attach(fragmentShader, GL.FRAGMENT_SHADER);
        program.link();

        return program;
    }
}
