
import sys
import mysql.connector


def main(query_number, *parameters):
    if len(sys.argv) < 2:
        print("Usage: python proj.py <query_number> [parameter]")
        return

    try:
        query_number = int(sys.argv[1])
    except ValueError:
        print("Error: Query number must be from 1 to 8.")
        return

    if query_number not in range(1, 9):
        print("Error: Query number must be from 1 to 8.")
        return

    # Read the parameter for the selected query.
    if query_number == 2:
        if len(sys.argv) != 2:
            print("Usage: python3 proj.py 2")
            return
        parameter = None

    else:
        if len(sys.argv) < 3:
            usage = {
                1: '<procedure_name>',
                3: '<given_cost>',
                4: '<department_name>',
                5: '<medication_name>',
                6: '<date>',
                7: '<date>',
                8: '<department_name>'
            }
            print(f"Usage: python proj.py {query_number} {usage[query_number]}")
            return

        if query_number in (1, 4, 5, 8):
            parameter = " ".join(sys.argv[2:])
        elif query_number == 3:
            try:
                parameter = float(sys.argv[2])
            except ValueError:
                print("Error: Cost must be a number.")
                return
        else:
            parameter = sys.argv[2]

    queries = {
        1: """
            SELECT DISTINCT
                p.physicianID, p.name, p.position, p.ssn
            FROM Physician p
            JOIN Undergoes u ON u.physicianID = p.physicianID
            JOIN `Procedure` pr ON pr.procID = u.procedureID
            WHERE pr.name = %s
        """,

        2: """
            SELECT
                pt.name AS patient_name,
                ph.name AS physician_name,
                n.name AS nurse_name,
                a.startDateTime AS start_datetime,
                a.endDateTime AS end_datetime,
                primary_ph.name AS primary_physician
            FROM Appointment a
            JOIN Patient pt ON pt.patientID = a.patientID
            JOIN Physician ph ON ph.physicianID = a.physicianID
            JOIN Nurse n ON n.nurseID = a.nurseID
            JOIN Physician primary_ph
                ON primary_ph.physicianID = pt.primaryPhysID
            WHERE a.physicianID <> pt.primaryPhysID
        """,

        3: """
            SELECT DISTINCT
                pt.patientID, pt.ssn, pt.name, pt.address,
                pt.dob, pt.phone, pt.InsuranceNumber, pt.primaryPhysID
            FROM Patient pt
            JOIN Undergoes u ON u.patientID = pt.patientID
            JOIN `Procedure` pr ON pr.procID = u.procedureID
            WHERE pr.cost > %s
        """,

        4: """
            SELECT DISTINCT
                pt.patientID, pt.ssn, pt.name, pt.address,
                pt.dob, pt.phone, pt.InsuranceNumber, pt.primaryPhysID
            FROM Patient pt
            JOIN Department d ON d.headID = pt.primaryPhysID
            WHERE d.name = %s
        """,

        5: """
            SELECT
                pt.name AS patient_name,
                ph.name AS physician_name,
                pr.prescribedDate AS prescribed_date
            FROM Prescribes pr
            JOIN Medication m ON m.medID = pr.medicationID
            JOIN Patient pt ON pt.patientID = pr.patientID
            JOIN Physician ph ON ph.physicianID = pr.physicianID
            WHERE m.name = %s
        """,

        6: """
            SELECT
                n.nurseID, n.name, n.position, n.ssn,
                oc.startDate AS on_call_start_date,
                oc.endDate AS on_call_end_date
            FROM Nurse n
            JOIN OnCall oc ON oc.nurseID = n.nurseID
            WHERE %s BETWEEN oc.startDate AND oc.endDate
        """,

        7: """
            SELECT
                s.roomID,
                pt.name AS patient_name,
                s.startDate AS stay_start_date,
                s.endDate AS stay_end_date
            FROM Stay s
            JOIN Room r ON r.roomID = s.roomID
            JOIN Patient pt ON pt.patientID = s.patientID
            WHERE r.roomType = 'Double'
              AND %s BETWEEN s.startDate AND s.endDate
              AND s.roomID IN (
                  SELECT s2.roomID
                  FROM Stay s2
                  WHERE %s BETWEEN s2.startDate AND s2.endDate
                  GROUP BY s2.roomID
                  HAVING COUNT(DISTINCT s2.patientID) > 1
              )
            ORDER BY s.roomID, s.startDate
        """,

        8: """
            SELECT
                pt.patientID,
                pt.ssn AS patient_ssn,
                pt.name AS patient_name,
                pt.address AS patient_address,
                pt.dob AS patient_dob,
                pt.phone AS patient_phone,
                pt.InsuranceNumber AS patient_insuranceNumber,
                pt.primaryPhysID AS patient_primaryPhysID,
                ph.physicianID,
                ph.name AS physician_name,
                ph.position AS physician_position,
                ph.ssn AS physician_ssn,
                a.appID AS appointmentID
            FROM Appointment a
            JOIN Patient pt ON pt.patientID = a.patientID
            JOIN Physician ph ON ph.physicianID = a.physicianID
            JOIN AffiliatedWith aw ON aw.physicianID = ph.physicianID
            JOIN Department d ON d.deptID = aw.departmentID
            WHERE d.name = %s
        """
    }

    if query_number == 2:
        parameters = ()
    elif query_number == 6:
        parameters = (parameter,)
    elif query_number == 7:
        parameters = (parameter, parameter)
    else:
        parameters = (parameter,)

    connection = None
    cursor = None

    try:
        connection = mysql.connector.connect(
            host="localhost",
            port=3306,
            user="root",
            password="Atk9677361324@",
            database="las_palmas_medical"
        )

        cursor = connection.cursor()
        cursor.execute(queries[query_number], parameters)
        results = cursor.fetchall()

        print(f"\nQuery {query_number} results:")

        if not results:
            print("No records found.")
            return

        columns = [column[0] for column in cursor.description]

        if query_number == 7:
            current_room = None

            for row in results:
                room_id, patient_name, start_date, end_date = row

                if room_id != current_room:
                    current_room = room_id
                    print(f"\nRoom ID: {room_id}")

                print(
                    f"Patient: {patient_name}, "
                    f"Stay Start Date: {start_date}, "
                    f"Stay End Date: {end_date}"
                )
        else:
            for row in results:
                print(", ".join(
                    f"{columns[i]}: {value}"
                    for i, value in enumerate(row)
                ))

    except mysql.connector.Error as error:
        print(f"Database error: {error}")

    finally:
        if cursor is not None:
            cursor.close()
        if connection is not None and connection.is_connected():
            connection.close()


if __name__ == "__main__":
    if len(sys.argv) < 2:
        print("Usage: python proj.py <query_number> [parameter]")
    else:
        try:
            query_number = int(sys.argv[1])
            parameters = sys.argv[2:]
            main(query_number, *parameters)
        except ValueError:
            print("Error: Query number must be from 1 to 8.")
