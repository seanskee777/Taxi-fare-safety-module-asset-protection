// Taxi Fare Safety Module Backend Logic
// Author: Sean Easton & OpenAI ChatGPT-5 Mini
// Purpose: Simulate safety checks, flagging, and pre-pickup validation

// Example list of flagged offenders
let flaggedPassengers = [
    { name: "John Doe", phone: "555-1234", address: "123 Main St", notes: "Repeated no-payment" },
    // Add additional known offenders here
];

// Function to check if passenger is flagged
function isFlagged(passenger) {
    return flaggedPassengers.some(p => 
        p.phone === passenger.phone || p.address === passenger.address
    );
}

// Pre-pickup validation
function validatePickup(passenger, pickupTime) {
    let issues = [];

    // Name required
    if (!passenger.name) issues.push("Full name is required");

    // Payment upfront required after 7 PM
    let hour = pickupTime.getHours();
    if (hour >= 19 && !passenger.paymentMethod) issues.push("Payment required upfront after 7 PM");

    // Pickup and dropoff addresses
    if (!passenger.pickupAddress) issues.push("Pickup address required");
    if (!passenger.dropoffAddress) issues.push("Drop-off address required");

    // Flagged check
    if (isFlagged(passenger)) issues.push("Passenger flagged for past incidents");

    return issues;
}

// Example usage
let passengerExample = {
    name: "Jane Smith",
    phone: "555-5678",
    pickupAddress: "456 Elm St",
    dropoffAddress: "789 Oak St",
    paymentMethod: "credit"
};

let pickupTimeExample = new Date("2025-12-20T20:15:00"); // 8:15 PM

let validationResult = validatePickup(passengerExample, pickupTimeExample);
console.log("Validation Issues:", validationResult); // Empty array = all good
