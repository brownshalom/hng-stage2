from fastapi.testclient import TestClient
from unittest.mock import MagicMock
from api import main

# Mock Redis
main.r = MagicMock()

client = TestClient(main.app)


def test_health():
    response = client.get("/health")
    assert response.status_code == 200
    assert "status" in response.json()


def test_create_job():
    response = client.post("/jobs")
    assert response.status_code == 200
    assert "job_id" in response.json()


def test_get_job():
    main.r.hget.return_value = b"queued"

    response = client.get("/jobs/test-id")
    assert response.status_code == 200

    # ensure redis was called
    main.r.hget.assert_called()
