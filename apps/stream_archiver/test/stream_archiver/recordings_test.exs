defmodule StreamArchiver.RecordingsTest do
  use StreamArchiver.DataCase

  alias StreamArchiver.Recordings

  describe "recordings" do
    alias StreamArchiver.Recordings.Recording

    import StreamArchiver.RecordingsFixtures

    @invalid_attrs %{}

    test "list_recordings/0 returns all recordings" do
      recording = recording_fixture()
      assert Recordings.list_recordings() == [recording]
    end

    test "get_recording!/1 returns the recording with given id" do
      recording = recording_fixture()
      assert Recordings.get_recording!(recording.id) == recording
    end

    test "create_recording/1 with valid data creates a recording" do
      valid_attrs = %{}

      assert {:ok, %Recording{} = recording} = Recordings.create_recording(valid_attrs)
    end

    test "create_recording/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Recordings.create_recording(@invalid_attrs)
    end

    test "update_recording/2 with valid data updates the recording" do
      recording = recording_fixture()
      update_attrs = %{}

      assert {:ok, %Recording{} = recording} = Recordings.update_recording(recording, update_attrs)
    end

    test "update_recording/2 with invalid data returns error changeset" do
      recording = recording_fixture()
      assert {:error, %Ecto.Changeset{}} = Recordings.update_recording(recording, @invalid_attrs)
      assert recording == Recordings.get_recording!(recording.id)
    end

    test "delete_recording/1 deletes the recording" do
      recording = recording_fixture()
      assert {:ok, %Recording{}} = Recordings.delete_recording(recording)
      assert_raise Ecto.NoResultsError, fn -> Recordings.get_recording!(recording.id) end
    end

    test "change_recording/1 returns a recording changeset" do
      recording = recording_fixture()
      assert %Ecto.Changeset{} = Recordings.change_recording(recording)
    end
  end
end
