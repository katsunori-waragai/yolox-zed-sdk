OpenGL のエラーのうち、いくつかはこういった理由で生じる。

## 理由１　引数の間違い
```
glutInitDisplayMode(GL_DOUBLE | GL_RGB | GL_DEPTH);
...should be
glutInitDisplayMode(GLUT_DOUBLE | GLUT_RGB | GLUT_DEPTH);
```
https://ubuntuforums.org/archive/index.php/t-1379495.html

統合環境によっては、参照できない変数にwarningが生じるので、それを見落とさ兄事。


### glutInit()の謎
なぜ、コマンドライン引数を必要とするのか？
https://www.opengl.org/resources/libraries/glut/spec3/node10.html
glutCreateWindow(文字列)は正しい。

### export MESA_GL_VERSION_OVERRIDE=3.3
- 謎の呪文 以下の行での異常終了が回避された。
```commandline
       viewer.init(camera_infos.camera_model, point_cloud_res, obj_param.enable_tracking)
```
