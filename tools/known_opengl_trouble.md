OpenGL のエラーのうち、いくつかはこういった理由で生じる。

```commandline
error check 1
error check 2
freeglut (demo_zed.py):  ERROR:  Internal error <FBConfig with necessary capabilities not found> in function fgOpenWindow
Segmentation fault (core dumped)
root@orin:~/yolox-zed-sdk/tools#
```

## 理由１　引数の間違い
```
glutInitDisplayMode(GL_DOUBLE | GL_RGB | GL_DEPTH);
...should be
glutInitDisplayMode(GLUT_DOUBLE | GLUT_RGB | GLUT_DEPTH);
```
https://ubuntuforums.org/archive/index.php/t-1379495.html

統合環境によっては、参照できない変数にwarningが生じるので、それを見落とさないこと。


### glutInit()の謎
なぜ、コマンドライン引数を必要とするのか？
https://www.opengl.org/resources/libraries/glut/spec3/node10.html
glutCreateWindow(文字列)は正しい。

### export MESA_GL_VERSION_OVERRIDE=3.3
- 謎の呪文 以下の行での異常終了が回避された。
```commandline
       viewer.init(camera_infos.camera_model, point_cloud_res, obj_param.enable_tracking)
```

### OpenGL の環境を確認するには
```commandline
-----
sudo glxinfo | grep OpenGL
OpenGL vendor string: NVIDIA Corporation
OpenGL renderer string: NVIDIA Tegra Orin (nvgpu)/integrated
OpenGL core profile version string: 4.6.0 NVIDIA 35.2.1
OpenGL core profile shading language version string: 4.60 NVIDIA
OpenGL core profile context flags: (none)
OpenGL core profile profile mask: core profile
OpenGL core profile extensions:
OpenGL version string: 4.6.0 NVIDIA 35.2.1
OpenGL shading language version string: 4.60 NVIDIA
OpenGL context flags: (none)
OpenGL profile mask: (none)
OpenGL extensions:
OpenGL ES profile version string: OpenGL ES 3.2 NVIDIA 35.2.1
OpenGL ES profile shading language version string: OpenGL ES GLSL ES 3.20
OpenGL ES profile extensions:
```


### Shaderがらみのエラー
- 以下のshader関連のエラーは `export MESA_GL_VERSION_OVERRIDE=3.3` で回避された。
```commandline
[2024-04-15 08:30:11 UTC][ZED][INFO] [Init]  Calibration file downloaded.
Traceback (most recent call last):
  File "/root/yolox-zed-sdk/tools/ogl_viewer/viewer.py", line 105, in compile
    raise RuntimeError('Shader compilation failed: %s' % (info))
RuntimeError: Shader compilation failed: b'0:2(10): error: GLSL 3.30 is not supported. Supported versions are: 1.10, 1.20, 1.30, 1.40, 1.00 ES, and 3.00 ES\n'

During handling of the above exception, another exception occurred:

Traceback (most recent call last):
  File "demo_zed.py", line 465, in <module>
    main(exp, args)
  File "demo_zed.py", line 458, in main
    imageflow_demo(predictor, vis_folder, current_time, args)
  File "demo_zed.py", line 307, in imageflow_demo
    viewer.init(camera_infos.camera_model, point_cloud_res, obj_param.enable_tracking)
  File "/root/yolox-zed-sdk/tools/ogl_viewer/viewer.py", line 419, in init
    self.shader_image = Shader(VERTEX_SHADER, FRAGMENT_SHADER)
  File "/root/yolox-zed-sdk/tools/ogl_viewer/viewer.py", line 75, in __init__
    vertex_id = self.compile(GL_VERTEX_SHADER, _vs)
  File "/root/yolox-zed-sdk/tools/ogl_viewer/viewer.py", line 108, in compile
    glDeleteShader(shader_id)
  File "src/errorchecker.pyx", line 58, in OpenGL_accelerate.errorchecker._ErrorChecker.glCheckError
OpenGL.error.GLError: GLError(
	err = 1281,
	description = b'invalid value',
	baseOperation = glDeleteShader,
	cArguments = (2,)
)
```
