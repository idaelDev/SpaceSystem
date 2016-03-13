using UnityEngine;
using System.Collections;

public class SpaceObject: MonoBehaviour {

    public Vector3 velocity;
    public Vector3 acceleration;
    public float mass = 1;

    public ESpaceObjectType objectType;

    public bool debug;


    public ESpaceObjectType ObjectType
    {
        get
        {
            return objectType;
        }

        set
        {
            objectType = value;
        }
    }

    // Use this for initialization


    void Update()
    {
        if(debug)
        {
            Debug.DrawLine(transform.position, transform.position + velocity, Color.red, 1000);
            //Debug.DrawLine(transform.position, Vector3.zero, Color.red, 1000);
        }
    }

    public void SetVelocity(float vx, float vy)
    {
        velocity = new Vector3(vx, 0, vy);
    }

    public Vector3 GetVelocity()
    {
        return velocity;
    }

    public void SetAcceleration(float ax, float ay,float az)
    {
        acceleration = new Vector3(ax, az, ay);
    }

    public void SetAcceleration(Vector3 newAcceleration)
    {
        acceleration = newAcceleration;
    }

    public Vector3 GetAcceleration()
    {
        return acceleration;
    }

    public void UpdatePosition()
    {
        //if (objectType != ESpaceObjectType.STAR)
        //{
            velocity += acceleration * Time.deltaTime * 10000;
            transform.position += velocity * Time.deltaTime * 10000;
        //}
    }

}

public enum ESpaceObjectType
{
    STAR,
    PLANET
}
