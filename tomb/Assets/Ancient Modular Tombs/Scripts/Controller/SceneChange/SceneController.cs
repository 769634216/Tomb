using System.Collections;
using System.Collections.Generic;
using UnityEngine;
using System;
using UnityEngine.SceneManagement;

public class SceneController : MonoBehaviour
{
    #region 字段
    private int currentIndex;
    private Action<float> onProgressChange;//加载进程
    private Action onFinish;

    private static SceneController _instance;
    #endregion

    #region 属性
    public static SceneController Instance
    {
        get
        {
            if (_instance == null)
            {
                GameObject obj = new GameObject("SceneController");
                obj.AddComponent<SceneController>();
            }

            return _instance;
        }
    }
    #endregion

    #region 生命周期
    private void Awake()
    {
        //SceneController是在场景加载时调用的，所以在场景切换时不能销毁
        DontDestroyOnLoad(gameObject);

        if (_instance != null) { throw new Exception("场景中存在多个SceneController"); }
        _instance = this;
    }
    #endregion

    #region 方法
    public void LoadScene(int index, Action<float> onProgressChange, Action onFinish)
    {
        this.currentIndex = index;
        this.onProgressChange = onProgressChange;
        this.onFinish = onFinish;

        StartCoroutine(LoadScene());

    }


    //协程来处理加载的逻辑
    private IEnumerator LoadScene()
    {
        yield return null;

        AsyncOperation asyncopertation = SceneManager.LoadSceneAsync(this.currentIndex);

        //判断场景，场景没加载完时不能往下，需要等一帧，再更新一下进度
        while (!asyncopertation.isDone)
        {
            yield return null;
            onProgressChange?.Invoke(asyncopertation.progress);
        }

        //等一秒钟
        yield return new WaitForSeconds(1f);
        onFinish?.Invoke();


    }
    #endregion


}
