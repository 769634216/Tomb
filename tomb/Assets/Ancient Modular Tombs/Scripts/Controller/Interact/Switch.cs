using System.Collections;
using System.Collections.Generic;
using UnityEngine;
using UnityEngine.Events;

//开关状态
public enum SwitchStatus
{
    Open,
    Close
}

public class Switch : MonoBehaviour
{
    public SwitchStatus switchStatus = SwitchStatus.Close;

    public UnityEvent onOpen;
    public UnityEvent onClose;

    public void Open()
    {
        if(switchStatus == SwitchStatus.Close)
        {
            switchStatus = SwitchStatus.Open;
            onOpen?.Invoke();

        }
    }

    public void Close()
    {
        if (switchStatus == SwitchStatus.Open)
        {
            switchStatus = SwitchStatus.Close;
            onClose?.Invoke();

        }
    }
    
}
