#!/bin/bash

# Output file with timestamp
DATE=$(date +%F_%H-%M)
OUTPUT="/home/ubuntu/department_report_$DATE.csv"
COMPRESSED="/home/ubuntu/department_report_$DATE.tar.gz"

# Run SQL query and export to CSV (using sudo for root access)
sudo mysql -e "USE company; SELECT department, COUNT(*) AS employees, AVG(salary) AS avg_salary, SUM(salary) AS total_salary FROM employees GROUP BY department ORDER BY total_salary DESC;" \
| sed 's/\t/,/g' > $OUTPUT

# Compress the file
tar -czf $COMPRESSED $OUTPUT

# Log success
echo "Report generated: $COMPRESSED at $(date)" >> /home/ubuntu/report.log

