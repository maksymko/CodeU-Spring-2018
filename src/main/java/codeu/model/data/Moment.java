package codeu.model.data;

import java.time.Instant;
import java.util.UUID;

/** Class representing a Moment. Moments are sent by a User on the Profile Page. */
public class Moment {

  private final UUID id;
  private final UUID userId;
  private final String content;
  private final Instant creation;
  private final String location; // TODO: location format

  /**
   * Constructs a new Moment.
   *
   * @param id       the ID of this Moment
   * @param userId   the ID of the User this Moment belongs to
   * @param content  the text content of this Moment
   * @param creation the creation time of this Moment
   * @param location the location of User when publishing this Moment
   */
  public Moment(UUID id, UUID userId, String content, Instant creation, String location) {
    this.id = id;
    this.userId = userId;
    this.content = content;
    this.creation = creation;
    this.location = location;
  }

  /**
   * Returns the ID of this Moment.
   */
  public UUID getId() {
    return id;
  }

  /**
   * Returns the ID of the User this Moment belongs to.
   */
  public UUID getUserId() {
    return userId;
  }

  /**
   * Returns the text content of this Moment.
   */
  public String getContent() {
    return content;
  }

  /**
   * Returns the creation time of this Moment.
   */
  public Instant getCreationTime() {
    return creation;
  }

  /**
   * Returns the location of User when publishing this Moment.
   */
  public String getLocation() {
    return location;
  }
}
