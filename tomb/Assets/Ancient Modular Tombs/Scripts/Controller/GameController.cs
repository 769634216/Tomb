using System.Collections;
using System.Collections.Generic;
using UnityEngine;
using UnityEditor;

public class GameController : MonoBehaviour
{
    public void ExitGame()
    {
        //该方法在编辑器模式下不能调用，需要用预处理指令进行判断
#if UNITY_EDITOR

        EditorApplication.isPlaying = false;//此时编辑器由运行状态变为非运行状态

#else

        Application.Quit();

#endif


    }
}
