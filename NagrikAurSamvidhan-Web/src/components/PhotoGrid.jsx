import React from "react";
import assembly from '../assets/assembly.jpg'
import assem1 from '../assets/assem1.jpg'
import assem2 from '../assets/assem2.jpg'
import cover from '../assets/cover.jpg'
import prasad from '../assets/prasad.jpg'
import midnight from '../assets/midnight.jpg'
import sessionca from '../assets/sessionca.jpg'
import inscribe from '../assets/inscription.jpg'
import sardar from '../assets/sardar.jpg'



const PhotoGrid = () => {
  const photos = [
    {
      id: 1,
      description: "Group photograph of the members of the Constituent Assembly of India (Legislative), 1949 including Dr. B.R. Ambedkar",
      imageUrl: assem2,
    },
    {
      id: 2,
      description: "Group Photograph of the then members of the Constituent Assembly of India, 1950 when the consititution was adopted",
      imageUrl: (assem1),
    },
    {
      id: 3,
      description: "Dr.Rajendra Prasad, President of the Constituent Assembly, signing the Constitution of India,  on 24 January 1950",
      imageUrl: (prasad),
    },
    {
      id: 4,
      description: "Sardar Vallabhai Patel in the session of Constituent Assembly, December 1946",
      imageUrl: (assembly),
    },
    {
      id: 5,
      description: "Constituent Assembly of India: A view of open session on 9 December 1946",
      imageUrl: (sessionca),
    },
    {
      id: 6,
      description: "Midnight Session of the Constituent Assembly held on 14-15 August 1947",
      imageUrl: (midnight),
    },
    {
      id: 7,
      description: "Cover page of the Calligraphic copy of the Constitution of India In English",
      imageUrl: (cover),
    },
    {
      id: 8,
      description: "Smt. Sarojini Naidu, played role as a key member in the Constituent Assembly",
      imageUrl: (sardar),
    },
    {
      id: 9,
      description: "Inscriptions at the Central Hall of Parliament refer to the meeting of the Constituent Assembly",
      imageUrl: (inscribe),
    },
    
  ];

  return (
    <div className="bg-gradient-to-br from-amber-100 to-white py-12 px-6">
      <h1 className="text-4xl font-bold text-center text-green-900 mb-8">Constituent Assembly Moments</h1>
    <div className="max-w-7xl mx-auto grid grid-cols-1 md:grid-cols-2 lg:grid-cols-3 gap-8">
      {photos.map((photo) => (
        <div
          key={photo.id}
          className="bg-white rounded-xl overflow-hidden shadow-lg transform transition-all duration-300 hover:scale-105 hover:shadow-2xl border border-amber-200"
        >
          <img
            src={photo.imageUrl}
            alt={photo.description}
            className="w-full h-52 object-cover"
          />
          <div className="p-2 bg-gradient-to-t from-amber-100 to-transparent">
            <p className="text-amber-800 font-serif my-1 text-center text-md">{photo.description}</p>
          </div>
        </div>
      ))}
    </div>
  </div>

  );
};

export default PhotoGrid;
