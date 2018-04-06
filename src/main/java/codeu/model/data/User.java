// Copyright 2017 Google Inc.
//
// Licensed under the Apache License, Version 2.0 (the "License");
// you may not use this file except in compliance with the License.
// You may obtain a copy of the License at
//
//    http://www.apache.org/licenses/LICENSE-2.0
//
// Unless required by applicable law or agreed to in writing, software
// distributed under the License is distributed on an "AS IS" BASIS,
// WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
// See the License for the specific language governing permissions and
// limitations under the License.

package codeu.model.data;
import java.time.Instant;
import java.util.UUID;
import org.mindrot.jbcrypt.*;

/** Class representing a registered user. */
public class User {
  private final UUID id;
  private final String name;
  private final String hashedPassword;
  private final Instant creation;
  private String about;
  private boolean isAdmin;

  /**
   * Constructs a new User.
   *
   * @param id the ID of this User
   * @param name the username of this User
   * @param hashedPassword the users password
   * @param creation the creation time of this User
   * @param about the aboutme information of the user
   */
  public User(UUID id, String name, String hashedPassword, Instant creation, String about) {
    this.id = id;
    this.name = name;
    this.creation = creation;
    this.hashedPassword = hashedPassword;
    this.about = about;
    isAdmin = false;
  }

  /** Returns the ID of this User. */
  public UUID getId() {
    return id;
  }
  /** Returns the about me of this User. */
  public String getAbout() {
    return about;
  }
  /** Changes the about me of this User. */
  public void setAbout(String about) {
    this.about = about;
  }

  /** Returns the username of this User. */
  public String getName() {
    return name;
  }

  /** Returns the password of this User. */
  public String getPassword() {
    return hashedPassword;
  }

  /** Returns the creation time of this User. */
  public Instant getCreationTime() {
    return creation;
  }

  /** Sets the user as an admin. */
  public void setAsAdmin() {
    isAdmin = true;
  }

  /** removes the user as an admin. */
  public void removeAsAdmin() {
    isAdmin = false;
  }

  /** Returns if the user is or is not admin  */
  public boolean getIsAdmin() { return isAdmin; }
}
