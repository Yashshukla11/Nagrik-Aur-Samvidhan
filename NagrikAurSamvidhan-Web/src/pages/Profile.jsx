import React from "react";
import {useUser } from "../login/UserContext";
const Profile = () => {
  const { user } = useUser();
  return (
    <div className="min-h-screen flex flex-col items-center py-10 mt-20">
      <div className="bg-white shadow-lg rounded-lg p-6 w-full max-w-lg">
        <div className="flex items-center justify-center">
          <img
            src={user.userPhoto}
            alt="Profile"
            className="w-32 h-32 rounded-full border-4 border-amber-500"
          />
        </div>
        <div className="text-center mt-6">
          <h2 className="text-2xl font-semibold text-gray-800">{user.name}</h2>
          <p className="text-xl mt-4">Email : {user.email} </p>
          <p className="text-xl mt-4">Gender : {user.gender} </p>

          <p className="text-xl mt-4">Phone No : {user.phoneNumber}</p>
          <p className ="text-xl mt-4">Age :  {user.age}</p>
          <p className =" text-xl 1 mt-4">Language : {user.language}</p>
        </div>
      
      </div>
    </div>
  );
};

export default Profile;