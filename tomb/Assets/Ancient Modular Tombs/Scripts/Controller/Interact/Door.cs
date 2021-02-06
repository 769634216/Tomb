using System.Collections;
using System.Collections.Generic;
using UnityEngine;
using UnityEngine.Events;

public enum DoorStatus
{
    Open,
    Close
}

public class Door : MonoBehaviour
{

    public DoorStatus doorStatus = DoorStatus.Close;

    //钥匙
    public int keyNum = 1;
    private int currentNum = 0;


    public UnityEvent onOpen;
    public UnityEvent onClose;

    public void Open()
    {
        currentNum++;

        if(doorStatus == DoorStatus.Close && currentNum == keyNum)
        {
            doorStatus = DoorStatus.Open;
            onOpen?.Invoke();
        }
    }

    public void Close()
    {
        if(doorStatus == DoorStatus.Open)
        {
            doorStatus = DoorStatus.Close;
            onClose?.Invoke();
        }

    }

}
