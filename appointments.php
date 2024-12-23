<?php include 'db.php'; ?>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>Appointments</title>
    <link rel="stylesheet" href="style.css">
</head>
<body>
    <div class="container">
        <!-- Навигационные кнопки -->
        <div class="navigation">
            <a href="index.php" class="button">Doctors</a>
            <a href="appointments.php" class="button">Appointments</a>
            <a href="working_hours.php" class="button">Working Hours</a>
        </div>

        <h1>Appointments</h1>

        <?php
        // Обработка удаления записи
        if (isset($_POST['delete_appointment'])) {
            $appointment_id = $_POST['appointment_id'];

            // Получаем данные назначения для обновления статуса времени
            $sql = "SELECT doctor_id, appointment_date, appointment_time FROM Appointments WHERE appointment_id = ?";
            $stmt = $conn->prepare($sql);
            $stmt->bind_param("i", $appointment_id);
            $stmt->execute();
            $result = $stmt->get_result();

            if ($result->num_rows > 0) {
                $row = $result->fetch_assoc();
                $doctor_id = $row['doctor_id'];
                $appointment_date = $row['appointment_date'];
                $appointment_time = $row['appointment_time'];

                // Удаляем запись из таблицы Appointments
                $delete_sql = "DELETE FROM Appointments WHERE appointment_id = ?";
                $stmt_delete = $conn->prepare($delete_sql);
                $stmt_delete->bind_param("i", $appointment_id);
                $stmt_delete->execute();

                // Если запись удалена, обновляем статус времени в таблице WorkingHours
                if ($stmt_delete->affected_rows > 0) {
                    $update_sql = "UPDATE WorkingHours 
                                   SET is_available = 1 
                                   WHERE doctor_id = ? AND working_day = ? AND working_hour = ?";
                    $stmt_update = $conn->prepare($update_sql);
                    $stmt_update->bind_param("iss", $doctor_id, $appointment_date, $appointment_time);
                    $stmt_update->execute();

                    // Проверка успешности обновления
                    if ($stmt_update->affected_rows > 0) {
                        echo "<p>Appointment deleted and availability restored successfully!</p>";
                    } else {
                        echo "<p>Failed to restore availability after deletion.</p>";
                    }

                    $stmt_update->close();
                } else {
                    echo "<p>Failed to delete appointment.</p>";
                }

                $stmt_delete->close();
            } else {
                echo "<p>Appointment not found.</p>";
            }
            $stmt->close();
        }
        ?>

        <table>
            <thead>
                <tr>
                    <th>Appointment ID</th>
                    <th>Doctor Name</th>
                    <th>Patient Name</th>
                    <th>Date</th>
                    <th>Time</th>
                    <th>Action</th>
                </tr>
            </thead>
            <tbody>
                <?php
                // Получаем все записи о назначениях
                $sql = "SELECT a.appointment_id, d.first_name, d.last_name, a.patient_name, a.appointment_date, a.appointment_time 
                        FROM Appointments a 
                        JOIN Doctors d ON a.doctor_id = d.doctor_id";
                $result = $conn->query($sql);

                if ($result->num_rows > 0) {
                    while($row = $result->fetch_assoc()) {
                        echo "<tr>
                                <td>" . $row["appointment_id"] . "</td>
                                <td>" . $row["first_name"] . " " . $row["last_name"] . "</td>
                                <td>" . $row["patient_name"] . "</td>
                                <td>" . $row["appointment_date"] . "</td>
                                <td>" . $row["appointment_time"] . "</td>
                                <td>
                                    <form method='post' action='appointments.php'>
                                        <input type='hidden' name='appointment_id' value='" . $row["appointment_id"] . "'>
                                        <input type='submit' name='delete_appointment' value='Delete' class='button' onclick='return confirm(\"Are you sure you want to delete this appointment?\");'>
                                    </form>
                                </td>
                              </tr>";
                    }
                } else {
                    echo "<tr><td colspan='6'>No appointments found</td></tr>";
                }
                ?>
            </tbody>
        </table>
    </div>
</body>
</html>
