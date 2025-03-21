import React from "react";
import { BrowserRouter as Router, Routes, Route } from "react-router-dom";
import TripCost from "./pages/TripCost";
import Drivers from "./pages/Drivers";
import CreateOrder from "./pages/CreateOrder";

function App() {
  return (
    <Router>
      <Routes>
        <Route path="/" element={<TripCost />} />
        <Route path="/drivers" element={<Drivers />} />
        <Route path="/create-order" element={<CreateOrder />} />
      </Routes>
    </Router>
  );
}

export default App;
