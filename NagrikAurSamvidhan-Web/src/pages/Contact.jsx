import React from "react";
const Contact = ()=> {
    
    return (
      <div>
        <form
      action="https://api.web3forms.com/submit"
      method="POST"
      className="max-w-md mx-auto bg-white p-8 rounded-lg shadow-md space-y-4 mt-10"
    >
      <input type="hidden" name="access_key" value="66da367c-5394-497d-8ecc-fb7a7fed6d21" />

      <div>
        <label htmlFor="name" className="block text-sm font-medium text-gray-700">Name</label>
        <input
          type="text"
          name="name"
          required
          className="mt-1 block w-full p-2 border border-gray-300 rounded-md shadow-sm focus:ring-blue-500 focus:border-blue-500 sm:text-sm"
        />
      </div>

      <div>
        <label htmlFor="email" className="block text-sm font-medium text-gray-700">Email</label>
        <input
          type="email"
          name="email"
          required
          className="mt-1 block w-full p-2 border border-gray-300 rounded-md shadow-sm focus:ring-blue-500 focus:border-blue-500 sm:text-sm"
        />
      </div>

      <div>
        <label htmlFor="message" className="block text-sm font-medium text-gray-700">Message</label>
        <textarea
          name="message"
          required
          className="mt-1 block w-full p-2 border border-gray-300 rounded-md shadow-sm focus:ring-blue-500 focus:border-blue-500 sm:text-sm"
          rows="4"
        ></textarea>
      </div>

      <input type="checkbox" name="botcheck" className="hidden" />
      <div>
        <button
          type="submit"
          className="w-full bg-amber-500 text-white font-bold py-2 px-4 rounded-md hover:bg-amber-600 focus:outline-none focus:ring-2 focus:ring-offset-2 focus:ring-blue-500"
        >
          Submit Form
        </button>
      </div>
    </form>
      </div>
    );
  }
  export default Contact;