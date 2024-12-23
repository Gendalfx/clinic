<?php include 'db.php'; ?>

<?php
// Обработка запроса на бронирование
if (isset($_POST['action']) && $_POST['action'] == 'book_appointment') {
    $doctor_id = $_POST['doctor_id'];
    $patient_name = $_POST['patient_name'];
    $appointment_date = $_POST['appointment_date'];
    $appointment_time = $_POST['appointment_time'];

    // Вставка нового назначения
    $insert_sql = "INSERT INTO Appointments (doctor_id, patient_name, appointment_date, appointment_time) 
                   VALUES (?, ?, ?, ?)";
    $stmt = $conn->prepare($insert_sql);
    $stmt->bind_param("isss", $doctor_id, $patient_name, $appointment_date, $appointment_time);

    if ($stmt->execute()) {
        // Обновление доступности рабочего времени
        $update_sql = "UPDATE WorkingHours 
                       SET is_available = 0 
                       WHERE doctor_id = ? AND working_day = ? AND working_hour = ?";
        $stmt_update = $conn->prepare($update_sql);
        $stmt_update->bind_param("iss", $doctor_id, $appointment_date, $appointment_time);
        $stmt_update->execute();

        // Отправляем успешный ответ обратно на клиентскую сторону
        echo json_encode(['success' => true, 'message' => 'Appointment booked successfully!']);
    } else {
        // Отправляем сообщение об ошибке
        echo json_encode(['success' => false, 'message' => 'Failed to book appointment. Please try again.']);
    }
}
?>
