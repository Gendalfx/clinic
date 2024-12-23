<?php
include 'db.php';

if (isset($_GET['doctor_id'])) {
    $doctor_id = $_GET['doctor_id'];

    // Получаем доступные даты для выбранного врача
    $dates_sql = "SELECT DISTINCT working_day FROM WorkingHours WHERE doctor_id = ? AND is_available = 1 ORDER BY working_day";
    $stmt = $conn->prepare($dates_sql);
    $stmt->bind_param("i", $doctor_id);
    $stmt->execute();
    $dates_result = $stmt->get_result();

    $dates = '<option value="">Select Date</option>';
    while ($row = $dates_result->fetch_assoc()) {
        $dates .= '<option value="' . $row['working_day'] . '">' . $row['working_day'] . '</option>';
    }

    // Получаем доступные времена для выбранной даты
    $times = '<option value="">Select Time</option>';
    if (isset($_GET['appointment_date'])) {
        $appointment_date = $_GET['appointment_date'];
        
        // Выбираем доступные времена из таблицы WorkingHours
        $times_sql = "SELECT working_hour FROM WorkingHours WHERE doctor_id = ? AND working_day = ? AND is_available = 1 ORDER BY working_hour";
        $stmt = $conn->prepare($times_sql);
        $stmt->bind_param("is", $doctor_id, $appointment_date);
        $stmt->execute();
        $times_result = $stmt->get_result();

        while ($row = $times_result->fetch_assoc()) {
            $times .= '<option value="' . $row['working_hour'] . '">' . $row['working_hour'] . '</option>';
        }
    }

    echo json_encode(['dates' => $dates, 'times' => $times]);
}
?>
