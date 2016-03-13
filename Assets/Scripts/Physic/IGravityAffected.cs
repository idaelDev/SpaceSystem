using UnityEngine;
using System.Collections;

public interface IGravityAffected {

    void InitVelocity();
    void ComputeAttractionWith(Vector3 position, float mass);
}
