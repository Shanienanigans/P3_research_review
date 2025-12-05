package uga.menik.csx370.services;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import uga.menik.csx370.models.Criterion;

import javax.sql.DataSource;
import java.sql.*;
import java.util.ArrayList;
import java.util.List;

@Service
public class CriterionService {

    private final DataSource dataSource;

    @Autowired
    public CriterionService(DataSource dataSource) {
        this.dataSource = dataSource;
    }

    // -------------------------------------------------------------
    // CREATE CRITERION
    // -------------------------------------------------------------
    public boolean addCriterion(String name, String description) {

        final String sql = """
            INSERT INTO criterion (name, description)
            VALUES (?, ?)
        """;

        try (Connection conn = dataSource.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {

            ps.setString(1, name);
            ps.setString(2, description);

            return ps.executeUpdate() > 0;

        } catch (Exception e) {
            e.printStackTrace();
            return false;
        }
    }

    // -------------------------------------------------------------
    // GET ALL CRITERIA
    // -------------------------------------------------------------
    public List<Criterion> getAllCriteria() {

        final String sql = "SELECT * FROM criterion ORDER BY name ASC";

        List<Criterion> list = new ArrayList<>();

        try (Connection conn = dataSource.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql);
             ResultSet rs = ps.executeQuery()) {

            while (rs.next()) {
                list.add(new Criterion(
                        rs.getString("criterionId"),
                        rs.getString("name"),
                        rs.getString("description")
                ));
            }

        } catch (Exception e) {
            e.printStackTrace();
        }

        return list;
    }

    // -------------------------------------------------------------
    // DELETE CRITERION
    // -------------------------------------------------------------
    public boolean deleteCriterion(String id) {

        final String sql = "DELETE FROM criterion WHERE criterionId = ?";

        try (Connection conn = dataSource.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {

            ps.setString(1, id);

            return ps.executeUpdate() > 0;

        } catch (Exception e) {
            e.printStackTrace();
            return false;
        }
    }
}
