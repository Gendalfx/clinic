<?php
include 'db.php';

if (isset($_GET['doctor_id']) && isset($_GET['appointment_date'])) {
    $doctor_id = $_GET['doctor_id'];
    $appointment_date = $_GET['appointment_date'];

    // Получаем доступные времена для выбранного врача и даты
    $times_sql = "SELECT appointment_time FROM Appointments WHERE doctor_id = ? AND appointment_date = ? ORDER BY appointment_time";
    $stmt = $conn->prepare($times_sql);
    $stmt->bind_param("is", $doctor_id, $appointment_date);
    $stmt->execute();
    $times_result = $stmt->get_result();

    $times = '<option value="">Select Time</option>';
    while ($row = $times_result->fetch_assoc()) {
        $times .= '<option value="' . $row['appointment_time'] . '">' . $row['appointment_time'] . '</option>';
    }

    echo json_encode(['times' => $times]);
}
?>
