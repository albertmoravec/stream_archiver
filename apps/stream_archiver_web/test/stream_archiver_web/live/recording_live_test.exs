defmodule StreamArchiverWeb.RecordingLiveTest do
  use StreamArchiverWeb.ConnCase

  import Phoenix.LiveViewTest
  import StreamArchiver.RecordingsFixtures

  @create_attrs %{}
  @update_attrs %{}
  @invalid_attrs %{}

  defp create_recording(_) do
    recording = recording_fixture()
    %{recording: recording}
  end

  describe "Index" do
    setup [:create_recording]

    test "lists all recordings", %{conn: conn} do
      {:ok, _index_live, html} = live(conn, Routes.recording_index_path(conn, :index))

      assert html =~ "Listing Recordings"
    end

    test "saves new recording", %{conn: conn} do
      {:ok, index_live, _html} = live(conn, Routes.recording_index_path(conn, :index))

      assert index_live |> element("a", "New Recording") |> render_click() =~
               "New Recording"

      assert_patch(index_live, Routes.recording_index_path(conn, :new))

      assert index_live
             |> form("#recording-form", recording: @invalid_attrs)
             |> render_change() =~ "can&#39;t be blank"

      {:ok, _, html} =
        index_live
        |> form("#recording-form", recording: @create_attrs)
        |> render_submit()
        |> follow_redirect(conn, Routes.recording_index_path(conn, :index))

      assert html =~ "Recording created successfully"
    end

    test "updates recording in listing", %{conn: conn, recording: recording} do
      {:ok, index_live, _html} = live(conn, Routes.recording_index_path(conn, :index))

      assert index_live |> element("#recording-#{recording.id} a", "Edit") |> render_click() =~
               "Edit Recording"

      assert_patch(index_live, Routes.recording_index_path(conn, :edit, recording))

      assert index_live
             |> form("#recording-form", recording: @invalid_attrs)
             |> render_change() =~ "can&#39;t be blank"

      {:ok, _, html} =
        index_live
        |> form("#recording-form", recording: @update_attrs)
        |> render_submit()
        |> follow_redirect(conn, Routes.recording_index_path(conn, :index))

      assert html =~ "Recording updated successfully"
    end

    test "deletes recording in listing", %{conn: conn, recording: recording} do
      {:ok, index_live, _html} = live(conn, Routes.recording_index_path(conn, :index))

      assert index_live |> element("#recording-#{recording.id} a", "Delete") |> render_click()
      refute has_element?(index_live, "#recording-#{recording.id}")
    end
  end

  describe "Show" do
    setup [:create_recording]

    test "displays recording", %{conn: conn, recording: recording} do
      {:ok, _show_live, html} = live(conn, Routes.recording_show_path(conn, :show, recording))

      assert html =~ "Show Recording"
    end

    test "updates recording within modal", %{conn: conn, recording: recording} do
      {:ok, show_live, _html} = live(conn, Routes.recording_show_path(conn, :show, recording))

      assert show_live |> element("a", "Edit") |> render_click() =~
               "Edit Recording"

      assert_patch(show_live, Routes.recording_show_path(conn, :edit, recording))

      assert show_live
             |> form("#recording-form", recording: @invalid_attrs)
             |> render_change() =~ "can&#39;t be blank"

      {:ok, _, html} =
        show_live
        |> form("#recording-form", recording: @update_attrs)
        |> render_submit()
        |> follow_redirect(conn, Routes.recording_show_path(conn, :show, recording))

      assert html =~ "Recording updated successfully"
    end
  end
end
