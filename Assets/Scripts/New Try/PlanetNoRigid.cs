using UnityEngine;
using System.Collections;
using System.Collections.Generic;
using System;

public class PlanetNoRigid : MonoBehaviour, IGravityAffected {

    Vector3 velocity;
    public float mass = 1;
    // Use this for initialization
    void Start () {

        InitVelocity();
    }

    // Update is called once per frame
    void Update()
    {
        ComputeAttractionWith(SystemManager.Instance.sun.position, SystemManager.Instance.sun.mass);
        foreach (PlanetNoRigid item in SystemManager.Instance.planets)
        {
            ComputeAttractionWith(item.transform.position, item.mass);
        }
        transform.position += velocity * Time.deltaTime;
    }

    public void InitVelocity()
    {
        float vz = Mathf.Sqrt((SystemManager.Instance.sun.mass * mass) / Vector3.Distance(SystemManager.Instance.sun.transform.position, transform.position));
        // body.AddForce(Vector3.forward * vz);
        if (transform.position.x < 0)
            vz *= -1;
        velocity = Vector3.forward * vz;
    }

    public void ComputeAttractionWith(Vector3 position, float otherMass)
    {
        Vector3 line = position - transform.position;
        float distance = Vector3.Distance(position, transform.position);
        if (distance != 0)
        {
            line.Normalize();
            velocity += (line * (mass * otherMass) / (distance * distance)) * Time.deltaTime;
        }
    }
}
