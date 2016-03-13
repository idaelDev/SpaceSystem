using UnityEngine;
using System.Collections;
using UnityEngine.UI;

public class UIManager : MonoBehaviour {

    public Slider timeSlider;
    public Text timeText;
    private PlanetInteraction selectedPlanet;
    public Text PositionText;
    public Text VelocityText;
    public Text MassText;
    public InputField massField;
    public InputField distanceField;
    public Canvas targetCanvas;

	// Use this for initialization
	void Start () {
        PlanetInteraction.OnPlanetSelected += SetSelectedPlanet;
	}

    void SetSelectedPlanet(PlanetInteraction p)
    {
        if (selectedPlanet != null)
        {
            selectedPlanet.ResetLine();
        }
        selectedPlanet = p;
    }

    void UpdateSelectedValue()
    {
        if(selectedPlanet!=null)
        {
            Vector3 position = selectedPlanet.transform.position;
            Vector3 velocity = selectedPlanet.planet.body.velocity;
            PositionText.text = "X = " + position.x + "; Y = " + position.y + "; Z = " + position.z;
            VelocityText.text = velocity.magnitude +"";
            MassText.text = selectedPlanet.planet.body.mass + "";
            selectedPlanet.DrawVelocity();
        }
    }
	
	// Update is called once per frame
	void Update () {
        UpdateSelectedValue();
        int distance = int.Parse(distanceField.text);
        targetCanvas.transform.LookAt(Camera.main.transform.position);
        targetCanvas.transform.position = Vector3.right * distance;
    }

    public void OnSpeedChange()
    {
        Time.timeScale = timeSlider.value / 100f;
        timeText.text = "Speed: "+timeSlider.value + "%";
    }

    public void OnRemove()
    {
        selectedPlanet.gameObject.SetActive(false);
    }

    public void OnAdd()
    {
        int mass = int.Parse(massField.text);
        int distance = int.Parse(distanceField.text);
        PlanetPoolManager.Instance.SpawnPlanet(Vector3.right * distance, mass);
    }
}
