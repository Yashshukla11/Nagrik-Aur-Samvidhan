import React from "react";
import { Link , useLocation} from "react-router-dom";

const RegistrationDone =()=>{
    const location = useLocation();
    const fromSignup = location.state?.fromSignup;
  
    if (!fromSignup) {
      return <div>Access Denied</div>;
    }
    return(
        <div className="min-h-screen flex items-center justify-center bg-green-100">
        <div className="max-w-md w-full bg-white p-8 rounded-lg shadow-md text-center">
          <h1 className="text-3xl font-bold text-green-600 mb-4">Registration Complete</h1>
          <p className="text-lg text-gray-700 mb-6">Thank you for registering! Your account has been created successfully.</p>
          <p className="text-gray-600 mb-6">You can now <Link to="/signin" className="text-green-600 hover:underline">log in</Link> to your account.</p>
          </div>
          </div>
    );
}
export default RegistrationDone