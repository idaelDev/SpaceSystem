using UnityEngine;
using System.Collections;
using System.Collections.Generic;
using System;

public class Planet : MonoBehaviour, IGravityAffected {

    public Rigidbody body;

    // Use this for initialization
    void Start () {
        body = GetComponent<Rigidbody>();

        InitVelocity();
    }

    // Update is called once per frame
    void FixedUpdate()
    {
        ComputeAttractionWith(SystemManager.Instance.sun.position, SystemManager.Instance.sun.mass);
        foreach (Planet item in SystemManager.Instance.planets)
        {
            ComputeAttractionWith(item.body.position, item.body.mass);
        }
    }

    public void InitVelocity()
    {
        float vz = Mathf.Sqrt(SystemManager.Instance.sun.mass / Vector3.Distance(SystemManager.Instance.sun.transform.position, transform.position));
        // body.AddForce(Vector3.forward * vz);
        if (transform.position.x < 0)
            vz *= -1;
        body.velocity = Vector3.forward * vz;
    }



   public void ComputeAttractionWith(Vector3 position, float mass)
    {
        Vector3 line = position - transform.position;
        float distance = Vector3.Distance(position, transform.position);
        if (distance != 0)
        {
            line.Normalize();
            body.AddForce(line * (body.mass * mass) / (distance * distance));
        }
    }
}
