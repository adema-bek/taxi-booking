import React, { useState } from "react";
import axios from "axios";
import { useNavigate } from "react-router-dom";

const TripCost = () => {
  const [pickup, setPickup] = useState("");
  const [destination, setDestination] = useState("");
  const [cost, setCost] = useState(null);
  const [loading, setLoading] = useState(false);
  const navigate = useNavigate();

  const API_URL = "http://localhost:5000/calculate-cost"; // Replace with actual API

  const calculateCost = async () => {
    if (!pickup || !destination) return alert("Enter all details!");

    setLoading(true);
    try {
      const response = await axios.post(`${API_URL}/calculate-cost`, { pickup, destination });
      setCost(response.data.cost);
    } catch (error) {
      console.error("Error fetching cost", error);
    } finally {
      setLoading(false);
    }
  };

  return (
    <div className="max-w-lg mx-auto p-5 bg-white shadow-md rounded-lg">
      <h2 className="text-xl font-bold mb-4">Calculate Trip Cost</h2>

      <input
        type="text"
        placeholder="Pickup Location"
        className="w-full p-2 mb-2 border rounded"
        value={pickup}
        onChange={(e) => setPickup(e.target.value)}
      />
      <input
        type="text"
        placeholder="Destination"
        className="w-full p-2 mb-2 border rounded"
        value={destination}
        onChange={(e) => setDestination(e.target.value)}
      />

      <button
        onClick={calculateCost}
        className="w-full bg-blue-500 text-white p-2 rounded mb-2"
        disabled={loading}
      >
        {loading ? "Calculating..." : "Calculate Cost"}
      </button>

      {cost !== null && <p className="text-lg font-bold">Estimated Cost: ${cost}</p>}

      <button
        onClick={() => navigate("/drivers")}
        className="w-full bg-green-500 text-white p-2 rounded mt-4"
      >
        Find Nearby Drivers
      </button>
    </div>
  );
};

export default TripCost;
