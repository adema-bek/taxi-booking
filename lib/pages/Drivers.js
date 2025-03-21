import React, { useState } from "react";
import axios from "axios";
import { useNavigate } from "react-router-dom";

const Drivers = () => {
  const [drivers, setDrivers] = useState([]);
  const [loading, setLoading] = useState(false);
  const navigate = useNavigate();

  const API_URL = "https://your-api-url.com"; // Replace with actual API

  const fetchDrivers = async () => {
    setLoading(true);
    try {
      const response = await axios.get(`${API_URL}/nearby-drivers`);
      setDrivers(response.data.drivers);
    } catch (error) {
      console.error("Error fetching drivers", error);
    } finally {
      setLoading(false);
    }
  };

  return (
    <div className="max-w-lg mx-auto p-5 bg-white shadow-md rounded-lg">
      <h2 className="text-xl font-bold mb-4">Nearby Drivers</h2>

      <button
        onClick={fetchDrivers}
        className="w-full bg-green-500 text-white p-2 rounded mb-2"
        disabled={loading}
      >
        {loading ? "Loading..." : "Find Drivers"}
      </button>

      <ul className="mt-2">
        {drivers.length > 0 ? (
          drivers.map((driver, index) => (
            <li key={index} className="p-2 border-b">{driver.name} - {driver.distance} km away</li>
          ))
        ) : (
          <p>No drivers found.</p>
        )}
      </ul>

      <button
        onClick={() => navigate("/create-order")}
        className="w-full bg-purple-500 text-white p-2 rounded mt-4"
      >
        Create Order
      </button>
    </div>
  );
};

export default Drivers;
