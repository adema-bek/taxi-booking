import React, { useState } from "react";
import axios from "axios";
import { useNavigate } from "react-router-dom";

const CreateOrder = () => {
  const [orderStatus, setOrderStatus] = useState(null);
  const [loading, setLoading] = useState(false);
  const navigate = useNavigate();

  const API_URL = "https://your-api-url.com"; // Replace with actual API

  const createOrder = async () => {
    setLoading(true);
    try {
      const response = await axios.post(`${API_URL}/create-order`, {
        pickup: "Your Pickup Location",
        destination: "Your Destination",
        cost: 100 // Replace with actual cost
      });
      setOrderStatus(response.data.message);
    } catch (error) {
      console.error("Error creating order", error);
    } finally {
      setLoading(false);
    }
  };

  return (
    <div className="max-w-lg mx-auto p-5 bg-white shadow-md rounded-lg">
      <h2 className="text-xl font-bold mb-4">Create Ride Order</h2>

      <button
        onClick={createOrder}
        className="w-full bg-purple-500 text-white p-2 rounded mb-2"
        disabled={loading}
      >
        {loading ? "Processing..." : "Confirm & Book Ride"}
      </button>

      {orderStatus && <p className="text-lg font-bold">{orderStatus}</p>}

      <button
        onClick={() => navigate("/")}
        className="w-full bg-gray-500 text-white p-2 rounded mt-4"
      >
        Back to Home
      </button>
    </div>
  );
};

export default CreateOrder;
