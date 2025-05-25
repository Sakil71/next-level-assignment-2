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

INSERT INTO
    rangers (name, region)
VALUES (
        'Alice Green',
        'Northern Hills'
    ),
    ('Bob White', 'River Delta'),
    (
        'Carol King',
        'Mountain Range'
    );

INSERT INTO
    species (
        common_name,
        scientific_name,
        discovery_date,
        conservation_status
    )
VALUES (
        'Snow Leopard',
        'Panthera uncia',
        '1775-01-01',
        'Endangered'
    ),
    (
        'Bengal Tiger',
        'Panthera tigris tigris',
        '1758-01-01',
        'Endangered'
    ),
    (
        'Red Panda',
        'Ailurus fulgens',
        '1825-01-01',
        'Vulnerable'
    ),
    (
        'Asiatic Elephant',
        'Elephas maximus indicus',
        '1758-01-01',
        'Endangered'
    );

INSERT INTO
    sightings (
        species_id,
        ranger_id,
        location,
        sighting_time,
        notes
    )
VALUES (
        1,
        1,
        'Peak Ridge',
        '2024-05-10 07:45:00',
        'Camera trap image captured'
    ),
    (
        2,
        2,
        'Bankwood Area',
        '2024-05-12 16:20:00',
        'Juvenile seen'
    ),
    (
        3,
        3,
        'Bamboo Grove East',
        '2024-05-15 09:10:00',
        'Feeding observed'
    ),
    (
        1,
        2,
        'Snowfall Pass',
        '2024-05-18 18:30:00',
        NULL
    );

-- Solution 1
INSERT INTO
    rangers (name, region)
VALUES ('Derek Fox', 'Coastal Plains');

-- Solution 2
SELECT COUNT(DISTINCT species_id) AS unique_species_count
FROM sightings;

--  SOlution 3
SELECT * FROM sightings WHERE location LIKE '%Pass%';

--  Solution 4
SELECT name, count(s.ranger_id) as total_sightings
FROM rangers as ra
    JOIN sightings as s ON ra.ranger_id = s.ranger_id
GROUP BY
    ra.name;

--  Solution 5
SELECT common_name
FROM species sp
    LEFT JOIN sightings st ON sp.species_id = st.species_id
WHERE
    st.sighting_id IS NULL;

--  Solution 6
SELECT common_name, sighting_time, name
FROM
    sightings st
    JOIN species sp ON st.species_id = sp.species_id
    JOIN rangers ra ON st.ranger_id = ra.ranger_id
ORDER BY st.sighting_time DESC
LIMIT 2;

--  Solution 7
UPDATE species
SET
    conservation_status = 'Historic'
WHERE
    extract(
        YEAR
        FROM discovery_date
    ) < 1800;

--  Solution 8
SELECT
    sighting_id,
    CASE
        WHEN extract(
            hour
            FROM sighting_time
        ) < 12 THEN 'Morning'
        WHEN extract(
            hour
            FROM sighting_time
        ) BETWEEN 12 AND 17  THEN 'Afternoon'
        ELSE 'Evening'
    END as time_of_day
FROM sightings;

--  Solution 9
DELETE FROM rangers
WHERE NOT EXISTS(
        SELECT 1
        FROM sightings
        WHERE
            sightings.ranger_id = rangers.ranger_id
    );
