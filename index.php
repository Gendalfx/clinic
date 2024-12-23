<?php include 'db.php'; ?>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>Doctors and Appointments</title>
    <link rel="stylesheet" href="style.css">
    <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
    <script>
        $(document).ready(function() {
            function validate_input(input, type) {
                var namePattern = /^[A-Za-zА-Яа-яЁёІіЇїЄє\s]+$/; // Допустим только буквы и пробелы
                if (type === 'name') {
                    return namePattern.test(input);
                }
                return false; // если тип не совпадает
            }

            // Когда меняется врач, загружаем доступные даты и времена
            $('#doctor_id').change(function() {
                var doctor_id = $(this).val();
                if (doctor_id) {
                    $.ajax({
                        url: 'get_available_times.php',
                        type: 'GET',
                        data: {doctor_id: doctor_id},
                        success: function(data) {
                            var response = JSON.parse(data);
                            $('#appointment_date').html(response.dates);
                            $('#appointment_time').html(response.times);
                        }
                    });
                } else {
                    $('#appointment_date').html('<option value="">Select Doctor first</option>');
                    $('#appointment_time').html('<option value="">Select Date first</option>');
                }
            });

            $('#appointment_date').change(function() {
                var doctor_id = $('#doctor_id').val();
                var appointment_date = $(this).val();
                if (doctor_id && appointment_date) {
                    $.ajax({
                        url: 'get_available_times.php',
                        type: 'GET',
                        data: {doctor_id: doctor_id, appointment_date: appointment_date},
                        success: function(response) {
                            var data = JSON.parse(response);
                            $('#appointment_time').html(data.times);
                        }
                    });
                }
            });

            $('#appointment-form').submit(function(event) {
                event.preventDefault();

                var doctor_id = $('#doctor_id').val();
                var patient_name = $('#patient_name').val();
                var appointment_date = $('#appointment_date').val();
                var appointment_time = $('#appointment_time').val();

                // Валидация имени пациента
                if (!validate_input(patient_name, 'name')) {
                    alert("Invalid patient name. Please use only letters and spaces.");
                    return;
                }

                $.ajax({
                    url: 'book_appointment.php',
                    type: 'POST',
                    data: {
                        doctor_id: doctor_id,
                        patient_name: patient_name,
                        appointment_date: appointment_date,
                        appointment_time: appointment_time,
                        action: 'book_appointment'
                    },
                    success: function(response) {
                        var data = JSON.parse(response);
                        if (data.success) {
                            alert("Appointment booked successfully!");
                            $('#appointment_time option:selected').prop('disabled', true); // Отключаем выбранное время
                        } else {
                            alert("Failed to book appointment: " + data.message);
                        }
                    }
                });
            });
        });
    </script>
</head>
<body>
    <div class="container">
        <div class="navigation">
            <a href="index.php" class="button">Doctors</a>
            <a href="appointments.php" class="button">Appointments</a>
            <a href="working_hours.php" class="button">Working Hours</a>
        </div>

        <h1>Doctors</h1>
        <ul>
            <?php
            $sql = "SELECT * FROM Doctors";
            $result = $conn->query($sql);
            if ($result->num_rows > 0) {
                while ($row = $result->fetch_assoc()) {
                    echo "<li>ID: " . $row["doctor_id"] . " - " . $row["first_name"] . " " . $row["last_name"] . "</li>";
                }
            } else {
                echo "No doctors available.";
            }
            ?>
        </ul>

        <h2>Book an Appointment</h2>
        <form id="appointment-form">
            <label for="doctor_id">Doctor:</label>
            <select id="doctor_id" name="doctor_id" required>
                <option value="">Select a doctor</option>
                <?php
                $sql = "SELECT * FROM Doctors";
                $result = $conn->query($sql);
                while ($row = $result->fetch_assoc()) {
                    echo "<option value='" . $row['doctor_id'] . "'>" . $row['first_name'] . " " . $row['last_name'] . "</option>";
                }
                ?>
            </select>
            <br>

            <label for="appointment_date">Date:</label>
            <select id="appointment_date" name="appointment_date" required>
                <option value="">Select Date first</option>
            </select>
            <br>

            <label for="appointment_time">Time:</label>
            <select id="appointment_time" name="appointment_time" required>
                <option value="">Select Date first</option>
            </select>
            <br>

            <label for="patient_name">Patient Name:</label>
            <input type="text" id="patient_name" name="patient_name" required>
            <br>

            <input type="submit" value="Book Appointment">
        </form>
    </div>
</body>
</html>
