# Local Cloud Infrastructure Practice

This project helps to understand cloud infrastructure concepts by simulating a cloud environment.

#### Think of the setup as a neighborhood where everything works together to keep the community running smoothly, safely, and efficiently—just like a real cloud network, but all local.
---

## Tools and Automation

This project uses:

- **MinIO**: Self-hosted object storage for data management.
- **Docker**: To containerize MinIO and network components locally.
- **MinIO Client (`mc`)**: For administration with user, policy, and batch job management.
- **Bash scripts**: Automate user creation, policy setup, key rotation, and encryption key batch rotation.
- **Cron/CI pipelines**: Suggested for scheduling automation jobs.
---

## The Neighborhood (Virtual Cloud Network - VCN)

The **Virtual Cloud Network (VCN)** is the entire neighborhood—a safe, private area where all the houses (servers and services) live and talk to each other.

---

## Streets (Subnets)

The neighborhood has different **streets** called subnets. Some are public where visitors can come freely, while others are private and hidden from outsiders.

---

## Houses (Servers and Backend Sets)

- **Web Server House:**  
  Shows visitors websites or applications.
- **Backend Server Houses:**  
  Handle the work behind the scenes and process requests.
- **Backend Set:**  
  A group of houses working together for specific jobs, like running events or chores collectively.

---

## Gates and Doors (Gateways)

- **Main Gate (Internet Gateway):**  
  The big gate where visitors arrive from the outside internet.
- **Back Gate (NAT Gateway):**  
  A secret door letting private houses send mail outside but stays hidden from strangers.
- **Magic Door (Service Gateway):**  
  Special door connecting only to trusted services within the neighborhood.

---

## Guards and Maps

- **Guards (Security Lists):**  
  Gatekeepers letting only trusted visitors into streets and houses.
- **Neighborhood Map (Route Table):**  
  Guides visitors and mail to the right destinations.

---

## Traffic Helpers

- **Traffic Cop (Load Balancer):**  
  Directs visitors evenly to different houses to avoid overcrowding.
- **Reception Desk (Listener):**  
  Welcomes visitors and tells the traffic cop what they want.

---

## Deliveries and Addresses

- **Address Book (CIDR Block):**  
  Lists house numbers so mail (data) knows where to go.
- **Mail Carrier (DHCP Options):**  
  Gives each house its address and mail directions.

---

## Safety and Access

- **House Inspector (Health Check):**  
  Ensures each house is open and ready for visitors.
- **Magical Keys (SSH Keys):**  
  Special keys to securely access and fix houses.

---

## Special Connections and Size

- **Secret Tunnel (Site-to-Site VPN):**  
  Connects your neighborhood to another safe neighborhood for private visits.
- **Traffic Cop Station Size (Shape):**  
  Determines how many visitors the traffic cop can manage simultaneously.

---

## Local Setup Summary

Your local device is the city builder and mayor, using tools like **Docker** to create:
- Houses (containers)
- Streets (networks)
- Traffic cops (load balancers)
- Gates (gateways)  
=======
# local-cloud
Local Cloud Infrastructure Practice
>>>>>>> a8a9067675055769595d791cff3911f50c465bd7
