CREATE Table rangers (
    ranger_id SERIAL PRIMARY KEY UNIQUE,
    name VARCHAR(100) NOT NULL,
    region VARCHAR(100) NOT NULL
);

CREATE Table species (
    species_id SERIAL PRIMARY KEY UNIQUE,
    common_name VARCHAR(50) NOT NULL,
    scientific_name VARCHAR(50) NOT NULL,
    discovery_date DATE NOT NULL,
    conservation_status VARCHAR(50)
);

CREATE Table sightings (
    sighting_id SERIAL PRIMARY KEY UNIQUE,
    ranger_id INT REFERENCES rangers (ranger_id),
    species_id INT REFERENCES species (species_id),
    sighting_time TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    location VARCHAR(100) NOT NULL,
    notes TEXT
);




SELECT * FROM rangers;
SELECT * FROM species;
SELECT * FROM sightings;