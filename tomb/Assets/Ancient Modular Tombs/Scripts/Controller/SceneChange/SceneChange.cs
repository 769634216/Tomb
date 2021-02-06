using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class SceneChange : MonoBehaviour
{
    public LoadView loadView;
    public int sceneIndex;

    public void Change()
    {
        if (loadView != null)
        {
            loadView.Show();
        }

        //命名函数
        SceneController.Instance.LoadScene(sceneIndex, (progress) =>
        {
            if (loadView)
            {
                loadView.UpdateProgress(progress);
            }

        }
        , () => {
            if (loadView)
            {
                loadView.Close();
            }
        });
    }
}
