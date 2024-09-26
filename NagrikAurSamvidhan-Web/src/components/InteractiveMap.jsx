import React, { useState } from 'react';
import { ComposableMap, Geographies, Geography } from 'react-simple-maps';
import axios from 'axios';

const geoUrl = "https://github.com/wmgeolab/geoBoundaries/raw/9469f09/releaseData/gbOpen/IND/ADM3/geoBoundaries-IND-ADM3.topojson";

const InteractiveMap = () => {
  const [selectedState, setSelectedState] = useState(null);
  const [stateFact, setStateFact] = useState('');

 
  const fetchWikipediaSummary = async (title) => {
    try {
      const response = await axios.get(`https://en.wikipedia.org/w/api.php`, {
        params: {
          action: 'query',
          format: 'json',
          titles: title,
          prop: 'extracts',
          exintro: true,
          explaintext: true,
          origin: '*'
        }
      });
  
      const page = response.data.query.pages;
      const pageId = Object.keys(page)[0];
      setStateFact(page[pageId].extract || "No information available for this state.");
    } catch (error) {
      console.error('Error fetching data from Wikipedia:', error);
      setStateFact("Error fetching information.");
    }
  };
  

  const handleMouseEnter = (geo) => {
    const stateName = geo.properties.name;
    setSelectedState(stateName);
    fetchWikipediaSummary(stateName); 
  };

  const handleMouseLeave = () => {
    setSelectedState(null);
    setStateFact('');
  };

  return (
    <div className="p-6">
      <h1 className="text-3xl font-bold mb-6 text-center text-blue-700">Interactive Map of India</h1>
      <div className="max-w-4xl mx-auto">
        <ComposableMap className="w-full">
          <Geographies geography={geoUrl}>
            {({ geographies }) =>
              geographies.map((geo) => (
                <Geography
                  key={geo.rsmKey}
                  geography={geo}
                  onMouseEnter={() => handleMouseEnter(geo)}
                  onMouseLeave={handleMouseLeave}
                  style={{
                    default: { fill: "#D6D6DA", outline: "none" },
                    hover: { fill: "#34D399", outline: "none" },
                    pressed: { fill: "#10B981", outline: "none" },
                  }}
                  className="transition-all duration-200 ease-in-out cursor-pointer"
                />
              ))
            }
          </Geographies>
        </ComposableMap>
      </div>
      {selectedState && (
        <div className="mt-6 p-4 bg-white rounded-lg shadow-lg border border-gray-200 max-w-md mx-auto">
          <h2 className="text-xl font-semibold text-gray-800">{selectedState}</h2>
          <p className="text-gray-600 mt-2">
            {stateFact}
          </p>
        </div>
      )}
    </div>
  );
};

export default InteractiveMap;
