package CloudTo_MQTT;

import org.eclipse.paho.client.mqttv3.*;

public class writeToMQTT {
    private static final MqttClient mqttclient = new MqttClient("tcp://localhost:1883", MqttClient.generateClientId());

    public static void publishSensor(String leituraSensor) {
        try {
            MqttMessage mqtt_message = new MqttMessage();
            mqtt_message.setPayload(leituraSensor.getBytes());
            mqttclient.connect();
            String cloud_topic = "topic_name";
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