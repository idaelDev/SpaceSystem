using UnityEngine;
using System.Collections;
using System.Collections.Generic;
using System;

public class Planet : MonoBehaviour, IGravityAffected {

    public Rigidbody body;

    // Use this for initialization
    void Start () {

        Init();
        InitVelocity();
    }

    public void Init()
    {
        body = GetComponent<Rigidbody>();
    }

    // Update is called once per frame
    void FixedUpdate()
    {
        ComputeAttractionWith(SystemManager.Instance.sun.position, SystemManager.Instance.sun.mass);
        int i = 0;
        foreach (IGravityAffected item in SystemManager.Instance.planets)
        {
            i++;
            ComputeAttractionWith(((Planet)(item)).body.position, ((Planet)(item)).body.mass);
        }
        //Debug.Log(i);
    }

    public void InitVelocity()
    {
        float vz = Mathf.Sqrt((SystemManager.Instance.sun.mass * body.mass) / Vector3.Distance(SystemManager.Instance.sun.transform.position, transform.position));
        // body.AddForce(Vector3.forward * vz);
        if (transform.position.x < 0)
            vz *= -1;
        body.velocity = Vector3.forward * vz;
    }



   public void ComputeAttractionWith(Vector3 otherPosition, float otherMass)
    {
        Vector3 line = otherPosition - body.position;
        float distance = Vector3.Distance(otherPosition, body.position);
        if (distance != 0)
        {
            line.Normalize();
            body.velocity += (line * (body.mass * otherMass) / (distance * distance)) * Time.deltaTime;
        }
    }
}
