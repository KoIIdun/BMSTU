USE Lab
GO

-- ������� ������ - ������ ����������������� ���������
-- ����������������� - ��� ��������� ������ � ������ ����� ���������� ������ ��������
-- ��������� -- ��� ������ ������ ����� �������� �������������� ������

-- ������������� ������   (read uncommited) ��� ����� ������, ����� �������� ������ � ����������������� ������
-- ����������� ������       (read commited) ��� �������� ������, �������� ���������� ��������� ��������, � ������� ���������� ������, ��������������� ��������������� ���������� (S ������)
-- ��������������� ������ (repeatable read) ��� ������������������� ������, �������� ������� �����������, ������ ���������� �� ����� ������ �������, �� ����� ��������� ������
-- ���������������           (serializable) ��� ���������� ������, ��������� ������������� ���� �� ����� ����������

-- S (�����) = ������ �������� ������������ ����� ������ � �������.
-- X (������������) = ������ � ���������� ��������������� ������������ ������ � �������.
-- IX (� ���������� ������������ �������) = ��������� �� ��������� ��������� ���������� X �� ��������� ����������� ������� � �������� ����������.
-- IS (���������� �����) = ��������� ��������� ��������� ���������� S �� ��������� ����������� ������ � �������� ����������.
-- RangeS_S (����� Key-Range � ���������� ������ �������) = ��������� �� ������������� �������� ���������.
-- RangeI_N (������� Key-Range � ���������� ������� NULL) = ������������ ��� �������� ���������� ����� �������� ������ ����� � ������.

SET TRANSACTION ISOLATION LEVEL READ UNCOMMITTED
BEGIN TRANSACTION
 	SELECT * FROM Workers
 	UPDATE Workers SET bonus += 1 WHERE WorkerId = 1 
 	WAITFOR DELAY '00:00:05'
	SELECT * FROM Workers
	SELECT * FROM sys.dm_tran_locks
COMMIT TRAN
GO 


SET TRANSACTION ISOLATION LEVEL READ COMMITTED
BEGIN TRANSACTION
    SELECT * FROM Workers
    WAITFOR DELAY '00:00:05'
	UPDATE Workers SET bonus += 1 WHERE WorkerId = 1
    SELECT * FROM Workers
    SELECT * FROM sys.dm_tran_locks
COMMIT TRANSACTION;
GO


SET TRANSACTION ISOLATION LEVEL REPEATABLE READ
BEGIN TRANSACTION
    SELECT * FROM Workers  
    WAITFOR DELAY '00:00:05'  
    SELECT * FROM Workers
    SELECT * FROM sys.dm_tran_locks;
COMMIT TRANSACTION
GO


SET TRANSACTION ISOLATION LEVEL SERIALIZABLE
BEGIN TRANSACTION
    SELECT * FROM Workers 
    WAITFOR DELAY '00:00:10'  
    SELECT * FROM Workers
    SELECT * FROM sys.dm_tran_locks
COMMIT TRANSACTION
GO
