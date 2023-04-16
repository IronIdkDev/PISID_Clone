package CloudTo_ReplicaSet;

import org.eclipse.paho.client.mqttv3.MqttException;
import org.eclipse.paho.client.mqttv3.MqttMessage;

public class writeToMQTT {
    private static String cloud_topic = "topic_name";
    private static MqttClient mqttclient = new MqttClient("tcp://localhost:1883", MqttClient.generateClientId());

    public static void publishSensor(String leituraSensor) {
        try {
            MqttMessage mqtt_message = new MqttMessage();
            mqtt_message.setPayload(leituraSensor.getBytes());
            mqttclient.connect();
            mqttclient.publish(cloud_topic, mqtt_message);
            mqttclient.disconnect();
        } catch (MqttException e) {
            e.printStackTrace();
        }
    }

    public static void main(String[] args) {
        String sensorReading = "some_reading";
        publishSensor(sensorReading);
    }
}