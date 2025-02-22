CREATE DATABASE chinook;
SHOW DATABASES;
USE chinook;
SHOW TABLES;
--	The queries that will be showcased now will be to create helpful insights --


--	It identifies the most popular tracks based on sales, which can guide marketing efforts or inventory decisions. --
SELECT t.Name AS TrackName, SUM(il.Quantity) AS TotalSold
FROM Track t
JOIN InvoiceLine il ON t.TrackId = il.TrackId
GROUP BY t.TrackId
ORDER BY TotalSold DESC
LIMIT 5;
 
--	It shows which music genres generate the most revenue, helping you focus on profitable genres for future inventory or promotions. --
SELECT g.Name AS Genre, SUM(il.UnitPrice * il.Quantity) AS TotalSales
FROM Track t
JOIN Genre g ON t.GenreId = g.GenreId
JOIN InvoiceLine il ON t.TrackId = il.TrackId
GROUP BY g.Name
ORDER BY TotalSales DESC;

--	It identifies high-value customers who can be targeted for loyalty programs or personalized offers. --
SELECT c.FirstName, c.LastName, SUM(i.Total) AS TotalSpent
FROM Customer c
JOIN Invoice i ON c.CustomerId = i.CustomerId
GROUP BY c.CustomerId
ORDER BY TotalSpent DESC
LIMIT 10;

--	It shows how sales have trended over time, helping you identify seasonal patterns or periods of high/low sales.	--
SELECT DATE_FORMAT(i.InvoiceDate, '%Y-%m') AS Month, SUM(i.Total) AS TotalSales
FROM Invoice i
GROUP BY DATE_FORMAT(i.InvoiceDate, '%Y-%m')
ORDER BY Month;

--	It identifies prolific artists with a large catalog, which can be useful for marketing or inventory planning.	--
SELECT a.Name AS ArtistName, COUNT(t.TrackId) AS NumberOfTracks
FROM Artist a
JOIN Album al ON a.ArtistId = al.ArtistId
JOIN Track t ON al.AlbumId = t.AlbumId
GROUP BY a.ArtistId
ORDER BY NumberOfTracks DESC
LIMIT 10;

--	It identifies popular playlists or those with a wide variety of tracks, which can be useful for promoting playlists or understanding customer preferences.	--
SELECT p.Name AS PlaylistName, COUNT(pt.TrackId) AS NumberOfTracks
FROM Playlist p
JOIN PlaylistTrack pt ON p.PlaylistId = pt.PlaylistId
GROUP BY p.PlaylistId
ORDER BY NumberOfTracks DESC
LIMIT 10;

--	It shows which media types (e.g., MPEG, AAC) are most commonly used, helping you understand customer preferences.	--
SELECT m.Name AS MediaType, COUNT(t.TrackId) AS NumberOfTracks
FROM MediaType m
JOIN Track t ON m.MediaTypeId = t.MediaTypeId
GROUP BY m.MediaTypeId
ORDER BY NumberOfTracks DESC;

--	It identifies regions with higher or lower spending habits, which can guide marketing or pricing strategies.	--
SELECT c.Country, AVG(i.Total) AS AverageInvoiceTotal
FROM Customer c
JOIN Invoice i ON c.CustomerId = i.CustomerId
GROUP BY c.Country
ORDER BY AverageInvoiceTotal DESC;