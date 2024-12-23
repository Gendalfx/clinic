<?php include 'db.php'; ?>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>Working Hours</title>
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

        <h1>Working Hours</h1>

        <?php
        // Обработка изменения доступности только если форма была отправлена
        if ($_SERVER['REQUEST_METHOD'] == 'POST' && isset($_POST['update_availability'])) {
            $working_hour_id = $_POST['working_hour_id'];
            $is_available = $_POST['is_available'] == '1' ? 1 : 0;

            // Обновляем значение доступности только при изменении
            $update_sql = "UPDATE WorkingHours SET is_available = ? WHERE working_hour_id = ?";
            $stmt = $conn->prepare($update_sql);
            $stmt->bind_param("ii", $is_available, $working_hour_id);
            $stmt->execute();

            // Проверяем, если обновление успешно
            if ($stmt->affected_rows > 0) {
                echo "<p>Availability updated successfully!</p>";
            } else {
                echo "<p>Failed to update availability.</p>";
            }
        }
        ?>

        <table>
            <thead>
                <tr>
                    <th>Doctor ID</th>
                    <th>Doctor Name</th>
                    <th>Working Day</th>
                    <th>Working Hour</th>
                    <th>Availability</th>
                    <th>Action</th>
                </tr>
            </thead>
            <tbody>
                <?php
                // Получаем рабочие часы всех врачей
                $sql = "SELECT * FROM WorkingHours w INNER JOIN Doctors d ON w.doctor_id = d.doctor_id";
                $result = $conn->query($sql);

                if ($result->num_rows > 0) {
                    while($row = $result->fetch_assoc()) {
                        // Определяем доступность в зависимости от значения is_available
                        $availability = $row["is_available"] == 1 ? 'Available' : 'Not Available';
                        $availability_value = $row["is_available"] == 1 ? '1' : '0';

                        echo "<tr>
                                <td>" . $row["doctor_id"] . "</td>
                                <td>" . $row["first_name"] . " " . $row["last_name"] . "</td>
                                <td>" . $row["working_day"] . "</td>
                                <td>" . $row["working_hour"] . "</td>
                                <td>$availability</td>
                                <td>
                                    <form method='post' action='working_hours.php'>
                                        <input type='hidden' name='working_hour_id' value='" . $row["working_hour_id"] . "'>
                                        <input type='hidden' name='is_available' value='" . ($row["is_available"] ? '0' : '1') . "'>
                                        <input type='submit' name='update_availability' value='" . ($row["is_available"] ? 'Set Not Available' : 'Set Available') . "' class='button'>
                                    </form>
                                </td>
                              </tr>";
                    }
                } else {
                    echo "<tr><td colspan='6'>No working hours available</td></tr>";
                }
                ?>
            </tbody>
        </table>
    </div>
</body>
</html>
