using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class MenuView : ViewBase
{
    public LoadView loadView;

    public void OnStartButtonClick()
    {
        /*
        if (loadView != null)
        {
            loadView.Show();
        }

        SceneController.Instance.LoadScene(1, (progress) =>
        {
            if (loadView)
            {
                loadView.UpdateProgress(progress);
            }
            
        }
        , ()=> {
            if (loadView)
            {
                loadView.Hide();
            }
        });*/
    }
}
