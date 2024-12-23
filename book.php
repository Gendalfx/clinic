<?php
include 'db.php';

// Если форма отправлена
if ($_SERVER["REQUEST_METHOD"] == "POST") {
    $doctor_id = $_POST['doctor_id'];
    $appointment_date = $_POST['appointment_date'];
    $appointment_time = $_POST['appointment_time'];
    $patient_name = $_POST['patient_name'];

    // Добавление записи в базу данных
    $sql = "INSERT INTO Appointments (doctor_id, appointment_date, appointment_time, patient_name) 
            VALUES (?, ?, ?, ?)";
    
    $stmt = $conn->prepare($sql);
    $stmt->bind_param("isss", $doctor_id, $appointment_date, $appointment_time, $patient_name);
    
    if ($stmt->execute()) {
        // Запись добавлена успешно
        // Сохраняем сообщение для отображения на той же странице
        header("Location: index.php?status=success");
        exit();
    } else {
        // Ошибка добавления записи
        header("Location: index.php?status=error");
        exit();
    }
}
?>
